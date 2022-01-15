/*==============================================================================
Copyright (c) 2010-2014 Qualcomm Connected Experiences, Inc.
All Rights Reserved.
Confidential and Proprietary - Protected under copyright and other laws.
==============================================================================*/

using UnityEngine;

namespace Vuforia
{
    /// <summary>
    /// A custom handler that implements the ITrackableEventHandler interface.
    /// </summary>
    public class DefaultTrackableEventHandlerOld : MonoBehaviour,
                                                ITrackableEventHandler
    {
        #region PRIVATE_MEMBER_VARIABLES
 
        private TrackableBehaviour mTrackableBehaviour;
        public AudioSource aSource;
        public AudioClip aClip;
    
        #endregion // PRIVATE_MEMBER_VARIABLES



        #region UNTIY_MONOBEHAVIOUR_METHODS
    
        void Start()
        {
            mTrackableBehaviour = GetComponent<TrackableBehaviour>();
            if (mTrackableBehaviour)
            {
                mTrackableBehaviour.RegisterTrackableEventHandler(this);
            }
        }

        #endregion // UNTIY_MONOBEHAVIOUR_METHODS



        #region PUBLIC_METHODS

        /// <summary>
        /// Implementation of the ITrackableEventHandler function called when the
        /// tracking state changes.
        /// </summary>
        public void OnTrackableStateChanged(
                                        TrackableBehaviour.Status previousStatus,
                                        TrackableBehaviour.Status newStatus)
        {
            if (newStatus == TrackableBehaviour.Status.DETECTED ||
                newStatus == TrackableBehaviour.Status.TRACKED ||
                newStatus == TrackableBehaviour.Status.EXTENDED_TRACKED)
            {
                OnTrackingFound();
            }
            else
            {
                OnTrackingLost();
            }
        }

        #endregion // PUBLIC_METHODS



        #region PRIVATE_METHODS


        private void OnTrackingFound()
        {
           
            Renderer[] rendererComponents = GetComponentsInChildren<Renderer>(true);
            Collider[] colliderComponents = GetComponentsInChildren<Collider>(true);

            // Enable rendering:
            foreach (Renderer component in rendererComponents)
            {
                component.enabled = true;
            }

            // Enable colliders:
            foreach (Collider component in colliderComponents)
            {
                component.enabled = true;
            }

            Debug.Log("Trackable " + mTrackableBehaviour.TrackableName + " found");

            SystemConfig.instance.GUI_AR.SetActive(false);

            if (mTrackableBehaviour.TrackableName == "teratai")
            {
                aSource.PlayOneShot(aClip);
            }
            if (mTrackableBehaviour.TrackableName == "sakura")
            {
                aSource.PlayOneShot(aClip);
            }
            if (mTrackableBehaviour.TrackableName == "matahari")
            {
                aSource.PlayOneShot(aClip);
            }
            if (mTrackableBehaviour.TrackableName == "mawar")
            {
                aSource.PlayOneShot(aClip);
            }
            if (mTrackableBehaviour.TrackableName == "melati")
            {
                aSource.PlayOneShot(aClip);
            }
            if (mTrackableBehaviour.TrackableName == "lili")
            {
                aSource.PlayOneShot(aClip);
            }
            if (mTrackableBehaviour.TrackableName == "anggrek")
            {
                aSource.PlayOneShot(aClip);
            }
        }


        private void OnTrackingLost()
        {
            Renderer[] rendererComponents = GetComponentsInChildren<Renderer>(true);
            Collider[] colliderComponents = GetComponentsInChildren<Collider>(true);

            // Disable rendering:
            foreach (Renderer component in rendererComponents)
            {
                component.enabled = false;
            }

            // Disable colliders:
            foreach (Collider component in colliderComponents)
            {
                component.enabled = false;
            }

            Debug.Log("Trackable " + mTrackableBehaviour.TrackableName + " lost");

            SystemConfig.instance.GUI_AR.SetActive(true);

            if (mTrackableBehaviour.TrackableName == "teratai")
            {
                aSource.Stop();
            }
            if (mTrackableBehaviour.TrackableName == "sakura")
            {
                aSource.Stop();
            }
            if (mTrackableBehaviour.TrackableName == "matahari")
            {
                aSource.Stop();
            }
            if (mTrackableBehaviour.TrackableName == "mawar")
            {
                aSource.Stop();
            }
            if (mTrackableBehaviour.TrackableName == "melati")
            {
                aSource.Stop();
            }
            if (mTrackableBehaviour.TrackableName == "lili")
            {
                aSource.Stop();
            }
            if (mTrackableBehaviour.TrackableName == "anggrek")
            {
                aSource.Stop();
            }
        }
        

        #endregion // PRIVATE_METHODS
    }
}
